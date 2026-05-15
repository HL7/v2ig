"""Probe which Claude models on Vertex AI accept structured_outputs (messages.parse).

Dumps the full raw response or error body for each model so the result can be
shown verbatim to GCP/IaaS administrators.
"""
import json
import sys

from anthropic import AnthropicVertex, APIStatusError
from pydantic import BaseModel


class Reply(BaseModel):
    color: str
    reason: str


MODELS = [
    "claude-sonnet-4-6@default",
    "claude-sonnet-4-5@default",
    "claude-sonnet-4-5",
    "claude-haiku-4-5@default",
    "claude-haiku-4-5",
    "claude-opus-4-7@default",
    "claude-opus-4-1@default",
]


def dump(label, value):
    if isinstance(value, (dict, list)):
        print(f"  {label}:")
        for line in json.dumps(value, indent=4).splitlines():
            print(f"    {line}")
    else:
        print(f"  {label}: {value}")


def show_error(e):
    dump("Exception class", type(e).__name__)
    dump("HTTP status", getattr(e, "status_code", "?"))
    request_id = getattr(e, "request_id", None)
    if request_id is None and hasattr(e, "response"):
        request_id = e.response.headers.get("request-id")
    dump("request_id", request_id)
    body = getattr(e, "body", None)
    if body is None and hasattr(e, "response"):
        try:
            body = e.response.json()
        except Exception:
            body = e.response.text
    dump("Response body", body)


client = AnthropicVertex()
print(f"Client: AnthropicVertex")
print(f"  project_id = {client.project_id}")
print(f"  region     = {client.region}")
print()

for model in MODELS:
    print("=" * 72)
    print(f"MODEL: {model}")
    print("=" * 72)
    print(f"  Request: client.messages.parse(model={model!r}, output_format=Reply, ...)")
    try:
        resp = client.messages.parse(
            model=model,
            max_tokens=256,
            messages=[{"role": "user", "content": "Pick a color and give a one-sentence reason."}],
            output_format=Reply,
        )
        dump("Result", "SUCCESS")
        dump("Parsed output", str(resp.parsed_output))
        dump("usage", {"input_tokens": resp.usage.input_tokens, "output_tokens": resp.usage.output_tokens})
    except APIStatusError as e:
        dump("Result", "FAILED (APIStatusError)")
        show_error(e)
    except Exception as e:
        dump("Result", "FAILED (other)")
        dump("Exception class", type(e).__name__)
        dump("Message", str(e)[:1000])
    print()
