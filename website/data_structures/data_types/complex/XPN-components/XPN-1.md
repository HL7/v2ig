## XPN.1 - Family Name (FN)

This component allows full specification of the surname of a person. Where appropriate, it differentiates the person’s own surname from that of the person’s partner or spouse, in cases where the person’s name may contain elements from either name. It also permits messages to distinguish the surname prefix (such as "van" or "de") from the surname root. See section _2A.2.30_, "_FN - family name_".

_XPN.1_ will be empty when _XPN.7_ is MSK. It MAY be empty when _XPN.7_ is NAV.

**Usage Note:** If a person’s name has only one component, that name will be sent in _XPN.1 Family Name_. This is common practice in some countries such as Indonesia. This note does not cover the case where only one part of a person’s multi-part name is known (e.g., only know "John" of "John Doe").
