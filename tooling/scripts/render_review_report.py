#!/usr/bin/env python3
"""Render the V2 Management review report from Markdown to styled HTML.

Usage:
    python3 tooling/scripts/render_review_report.py
"""

import os
import re

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MD_PATH = os.path.join(PROJECT_ROOT, 'v291-extracted', 'v2mgmt-review-report.md')
HTML_PATH = os.path.join(PROJECT_ROOT, 'v291-extracted', 'v2mgmt-review-report.html')


def md_to_html(md_text):
    """Convert Markdown to HTML with basic formatting support."""
    lines = md_text.split('\n')
    html_lines = []
    in_table = False
    in_list = False
    in_code = False
    table_rows = []
    heading_slug_counts = {}

    def flush_table():
        nonlocal table_rows, in_table
        if not table_rows:
            return
        html_lines.append('<table>')
        for i, row in enumerate(table_rows):
            cells = [c.strip() for c in row.split('|')[1:-1]]
            if i == 0:
                html_lines.append('<thead><tr>' +
                    ''.join(f'<th>{inline(c)}</th>' for c in cells) +
                    '</tr></thead><tbody>')
            elif i == 1:
                continue  # separator row
            else:
                html_lines.append('<tr>' +
                    ''.join(f'<td>{inline(c)}</td>' for c in cells) +
                    '</tr>')
        html_lines.append('</tbody></table>')
        table_rows = []
        in_table = False

    def flush_list():
        nonlocal in_list
        if in_list:
            html_lines.append('</ul>')
            in_list = False

    def inline(text):
        """Process inline Markdown formatting.

        Code spans are extracted first and stashed under placeholders so
        that subsequent italic / bold substitutions can't mangle their
        contents (e.g. underscores inside `GUARANTOR_INSURANCE`).
        """
        code_spans = []

        def stash_code(m):
            code_spans.append(m.group(1))
            return f'\x00CODE{len(code_spans) - 1}\x00'

        text = re.sub(r'`([^`]+)`', stash_code, text)
        # Bold + italic
        text = re.sub(r'\*\*\*(.+?)\*\*\*', r'<strong><em>\1</em></strong>', text)
        # Bold
        text = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', text)
        # Italic (underscore and asterisk)
        text = re.sub(r'_(.+?)_', r'<em>\1</em>', text)
        text = re.sub(r'\*(.+?)\*', r'<em>\1</em>', text)
        # Links
        text = re.sub(r'\[([^\]]+)\]\(([^)]+)\)', r'<a href="\2">\1</a>', text)
        # Em dash
        text = text.replace(' — ', ' &mdash; ')
        text = text.replace('—', '&mdash;')
        # Restore code spans
        for i, body in enumerate(code_spans):
            text = text.replace(f'\x00CODE{i}\x00', f'<code>{body}</code>')
        return text

    for line in lines:
        stripped = line.strip()

        # Code blocks
        if stripped.startswith('```'):
            if in_code:
                html_lines.append('</code></pre>')
                in_code = False
            else:
                flush_table()
                flush_list()
                lang = stripped[3:].strip()
                html_lines.append(f'<pre><code class="{lang}">')
                in_code = True
            continue

        if in_code:
            html_lines.append(line)
            continue

        # Table rows
        if stripped.startswith('|') and stripped.endswith('|'):
            flush_list()
            in_table = True
            table_rows.append(stripped)
            continue
        elif in_table:
            flush_table()

        # Horizontal rules
        if stripped == '---' or stripped == '***':
            flush_list()
            html_lines.append('<hr>')
            continue

        # Headings
        heading_match = re.match(r'^(#{1,6})\s+(.+)', stripped)
        if heading_match:
            flush_list()
            level = len(heading_match.group(1))
            text = heading_match.group(2)
            base_slug = re.sub(r'[^a-z0-9]+', '-', text.lower()).strip('-')
            if base_slug in heading_slug_counts:
                heading_slug_counts[base_slug] += 1
                slug = f'{base_slug}-{heading_slug_counts[base_slug]}'
            else:
                heading_slug_counts[base_slug] = 0
                slug = base_slug
            html_lines.append(f'<h{level} id="{slug}">{inline(text)}</h{level}>')
            continue

        # Unordered list items
        list_match = re.match(r'^[-*]\s+(.+)', stripped)
        if list_match:
            if not in_list:
                html_lines.append('<ul>')
                in_list = True
            html_lines.append(f'<li>{inline(list_match.group(1))}</li>')
            continue

        # Ordered list items
        ol_match = re.match(r'^(\d+)\.\s+(.+)', stripped)
        if ol_match:
            flush_list()
            # Simple: just wrap in <p> with number styling
            html_lines.append(f'<p class="numbered"><strong>{ol_match.group(1)}.</strong> {inline(ol_match.group(2))}</p>')
            continue

        # Blank lines
        if not stripped:
            flush_list()
            continue

        # Regular paragraphs
        flush_list()
        html_lines.append(f'<p>{inline(stripped)}</p>')

    flush_table()
    flush_list()

    return '\n'.join(html_lines)


def generate_toc(md_text):
    """Generate a table of contents from headings with unique slugs."""
    toc = []
    slug_counts = {}
    for line in md_text.split('\n'):
        match = re.match(r'^(#{2,3})\s+(.+)', line.strip())
        if match:
            level = len(match.group(1))
            text = match.group(2)
            base_slug = re.sub(r'[^a-z0-9]+', '-', text.lower()).strip('-')
            # Make slugs unique by appending a counter
            if base_slug in slug_counts:
                slug_counts[base_slug] += 1
                slug = f'{base_slug}-{slug_counts[base_slug]}'
            else:
                slug_counts[base_slug] = 0
                slug = base_slug
            toc.append((level, text, slug))
    return toc


def render(md_text):
    """Render full HTML document from Markdown."""
    toc = generate_toc(md_text)
    body = md_to_html(md_text)

    toc_html = '<nav class="toc"><h3>Contents</h3><ul>\n'
    for level, text, slug in toc:
        cls = 'toc-h3' if level == 3 else ''
        toc_html += f'<li class="{cls}"><a href="#{slug}">{text}</a></li>\n'
    toc_html += '</ul></nav>\n'

    return f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>V2+ IG Structural Comparison &mdash; V2 Management Review</title>
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    color: #1a1a1a; background: #f8f9fa; line-height: 1.6;
  }}

  .page {{ display: flex; max-width: 1200px; margin: 0 auto; }}

  /* Sidebar TOC */
  .toc {{
    width: 260px; flex-shrink: 0; position: sticky; top: 0;
    align-self: flex-start; height: 100vh; overflow-y: auto;
    padding: 24px 16px; background: #fff;
    border-right: 1px solid #e0e0e0;
  }}
  .toc h3 {{ font-size: 0.9em; text-transform: uppercase; letter-spacing: 0.05em;
             color: #888; margin-bottom: 12px; }}
  .toc ul {{ list-style: none; }}
  .toc li {{ margin-bottom: 4px; }}
  .toc a {{ text-decoration: none; color: #3498db; font-size: 0.85em;
            display: block; padding: 3px 6px; border-radius: 4px; }}
  .toc a:hover {{ background: #e8f4fd; }}
  .toc .toc-h3 {{ padding-left: 16px; }}
  .toc .toc-h3 a {{ font-size: 0.82em; color: #666; }}

  /* Main content */
  .content {{
    flex: 1; min-width: 0; padding: 32px 40px; max-width: 860px;
  }}

  h1 {{ font-size: 1.6em; color: #2c3e50; margin-bottom: 6px; }}
  h2 {{ font-size: 1.35em; color: #2c3e50; margin: 36px 0 12px;
        padding-bottom: 6px; border-bottom: 2px solid #3498db; }}
  h3 {{ font-size: 1.1em; color: #34495e; margin: 24px 0 8px; }}
  h4 {{ font-size: 1em; color: #555; margin: 16px 0 6px; }}

  p {{ margin-bottom: 12px; }}
  p.numbered {{ margin-bottom: 8px; }}

  hr {{ border: none; border-top: 1px solid #ddd; margin: 32px 0; }}

  ul {{ margin: 8px 0 16px 24px; }}
  li {{ margin-bottom: 4px; }}

  code {{
    background: #f0f0f0; padding: 1px 5px; border-radius: 3px;
    font-family: 'SF Mono', Consolas, monospace; font-size: 0.88em;
  }}
  pre {{
    background: #2c3e50; color: #ecf0f1; padding: 16px;
    border-radius: 6px; overflow-x: auto; margin: 12px 0 16px;
  }}
  pre code {{ background: none; padding: 0; color: inherit; }}

  /* Tables */
  table {{
    width: 100%; border-collapse: collapse; margin: 12px 0 20px;
    background: #fff; border-radius: 6px; overflow: hidden;
    box-shadow: 0 1px 3px rgba(0,0,0,0.08);
  }}
  thead th {{
    background: #2c3e50; color: #fff; text-align: left;
    padding: 10px 12px; font-size: 0.84em; font-weight: 600;
  }}
  td {{
    padding: 8px 12px; border-bottom: 1px solid #eee; font-size: 0.88em;
    vertical-align: top;
  }}
  tr:last-child td {{ border-bottom: none; }}
  tr:hover td {{ background: #f7fbff; }}

  strong {{ font-weight: 600; }}
  em {{ font-style: italic; }}
  a {{ color: #3498db; }}
  a:hover {{ text-decoration: underline; }}

  @media (max-width: 900px) {{
    .page {{ flex-direction: column; }}
    .toc {{ width: 100%; height: auto; position: static;
            border-right: none; border-bottom: 1px solid #e0e0e0; }}
    .content {{ padding: 20px; }}
  }}
</style>
</head>
<body>
<div class="page">
{toc_html}
<main class="content">
{body}
</main>
</div>
</body>
</html>"""


def main():
    with open(MD_PATH) as f:
        md_text = f.read()

    html = render(md_text)

    with open(HTML_PATH, 'w') as f:
        f.write(html)

    print(f"Rendered: {HTML_PATH}")


if __name__ == '__main__':
    main()
