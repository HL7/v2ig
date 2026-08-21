#!/usr/bin/env python3
"""Shared stylesheet for the committee briefings.

Two briefings are generated from this project -- one for the UTG subcommittee
of TSMG, one for V2 Management -- and they are read side by side by people who
sit on both bodies. They should look like one family of documents, so the
stylesheet lives here rather than being copied into each renderer.

The class vocabulary the briefings rely on:

  .asks-card    the "if you read one thing" panel at the top
  .item.k-KIND  one numbered item, colour-coded by kind on its left border
  p.ask         the boxed one-sentence ask every item ends with
  .counter      an amber box for evidence that cuts against the item
  .settled      a green box for something already decided on our side
  .badge b-*    the kind label
"""

STYLE = """
:root { --line: #d0d7de; --muted: #57606a; --ask: #8250df; }
* { box-sizing: border-box; }
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
  margin: 0; display: flex; color: #1f2328; line-height: 1.55; background: #fff; }

#sidebar { position: fixed; top: 0; left: 0; width: 290px; height: 100vh; overflow-y: auto;
  background: #f6f8fa; border-right: 1px solid var(--line); padding: 18px; font-size: 13px; }
#sidebar .brand { font-weight: 700; font-size: 14px; line-height: 1.3; }
#sidebar .brand-sub { color: var(--muted); font-size: 12px; margin: 2px 0 14px; }
#sidebar h2 { font-size: 11px; margin: 18px 0 6px; text-transform: uppercase;
  letter-spacing: .05em; color: var(--muted); font-weight: 700; }
#sidebar a { display: block; padding: 4px 0 4px 22px; color: #0969da; text-decoration: none;
  text-indent: -22px; }
#sidebar a:hover { text-decoration: underline; }
#sidebar a .n { display: inline-block; width: 18px; color: var(--muted); font-weight: 600; }
#sidebar a.top { padding-left: 0; text-indent: 0; font-weight: 600; margin-bottom: 4px; }

#main { margin-left: 290px; padding: 28px 44px 80px; max-width: 1080px; }
h1 { font-size: 25px; margin: 0; }
h2 { font-size: 19px; margin-top: 46px; border-bottom: 1px solid var(--line); padding-bottom: 5px; }
h2.plain { border: 0; margin: 0 0 2px; padding: 0; font-size: 17px; }
h3 { font-size: 16px; margin: 0 0 4px; line-height: 1.35; }
h3 .n { color: var(--muted); }
p.sub { color: var(--muted); margin-top: 3px; }
p.tight { margin-bottom: 0; }
p.lede { font-size: 15px; color: #414a53; margin: 6px 0 10px; }
p.tables { font-size: 12px; color: var(--muted); margin: 0 0 8px;
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace; }

/* The asks card: the one thing a five-minute reader sees. */
.asks-card { border: 2px solid var(--ask); border-radius: 10px; padding: 18px 22px;
  margin: 26px 0 8px; background: #fbf7ff; }
.asks-intro { color: var(--muted); margin: 0 0 12px; font-size: 14px; }
.asks-list { margin: 0; padding-left: 20px; }
.asks-list li { margin-bottom: 13px; }
.asks-list a { color: #1f2328; font-weight: 600; text-decoration: none;
  border-bottom: 1px solid #c297ff; }
.asks-list a:hover { background: #f0e2ff; }
.ask-line { color: #414a53; font-size: 13.5px; margin-top: 3px; }
.asks-foot { margin: 14px 0 0; font-size: 13px; color: var(--muted); }

.item { border: 1px solid var(--line); border-left-width: 5px; border-radius: 8px;
  padding: 16px 20px; margin: 18px 0; }
.item.k-decision { border-left-color: #bc4c00; }
.item.k-finding { border-left-color: #bf8700; }
.item.k-fyi { border-left-color: #8c959f; background: #fafbfc; }
.item > p:last-of-type { margin-bottom: 0; }

p.ask { background: #faf5ff; border: 1px solid #d8b9ff; border-left: 4px solid var(--ask);
  border-radius: 6px; padding: 10px 14px; margin: 14px 0 0; font-size: 14px; }
.ask-tag { display: inline-block; background: var(--ask); color: #fff; font-size: 10px;
  font-weight: 700; letter-spacing: .06em; padding: 2px 7px; border-radius: 9px;
  margin-right: 9px; vertical-align: 1px; }

.counter { background: #fff8c5; border: 1px solid #d4a72c; border-radius: 6px;
  padding: 10px 14px; margin: 14px 0; font-size: 14px; }
.settled { background: #dafbe1; border: 1px solid #4ac26b; border-radius: 6px;
  padding: 10px 14px; margin: 4px 0 14px; font-size: 14px; }

table { border-collapse: collapse; width: 100%; font-size: 13px; margin: 10px 0 14px; }
table.narrow { width: auto; min-width: 380px; }
th, td { border: 1px solid var(--line); padding: 6px 10px; text-align: left; vertical-align: top; }
th { background: #f6f8fa; }
td.num, th.num { text-align: right; width: 1%; white-space: nowrap; }
td.nowrap { white-space: nowrap; }
tr:nth-child(even) td { background: #fbfcfd; }

.metric-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  gap: 12px; margin: 20px 0 4px; }
.metric-card { border: 1px solid var(--line); border-radius: 8px; padding: 13px 10px;
  text-align: center; background: #fff; }
.metric-card .number { font-size: 23px; font-weight: 700; }
.metric-card .label { font-size: 11.5px; color: var(--muted); margin-top: 3px; line-height: 1.3; }
.mc-good .number { color: #1a7f37; }
.mc-flag .number { color: #bf8700; } .mc-flag { border-color: #e5c55c; }
.mc-escalate .number { color: var(--ask); } .mc-escalate { border-color: #c297ff; }

.badge { display: inline-block; padding: 2px 8px; border-radius: 10px; font-size: 10px;
  font-weight: 700; letter-spacing: .05em; color: #fff; white-space: nowrap;
  vertical-align: 2px; }
.b-decide { background: #bc4c00; } .b-flag { background: #bf8700; }
.b-info { background: #6e7781; }

/* A count riding alongside a sidebar link, and the same idea inline in a
   heading. Both are secondary to the text they sit beside and must not
   compete with it. */
#sidebar a .cnt { color: var(--muted); font-weight: 400; font-size: 11px;
  white-space: nowrap; }
.dim-tag { display: inline-block; background: #eaeef2; border-radius: 4px;
  padding: 1px 7px; font-size: 11px; font-weight: 600; color: #424a53;
  margin-left: 7px; vertical-align: 2px; }

code { background: #eff1f3; padding: 1px 5px; border-radius: 4px; font-size: 89%;
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace; }
ol, ul { padding-left: 22px; }
li { margin-bottom: 5px; }
.faint { color: #8b949e; font-size: 11.5px; margin-top: 40px; }

/* Shared as a PDF or printed for the room: the sidebar is noise on paper, and
   an item must not be split across a page break. */
@media print {
  #sidebar { display: none; }
  #main { margin: 0; max-width: none; padding: 0; }
  .item, .asks-card { break-inside: avoid; page-break-inside: avoid; }
  body { font-size: 11pt; }
}
"""
