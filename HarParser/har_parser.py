import json

from haralyzer import HarParser
from collections import defaultdict

with open('at.har', 'r') as f:
    har_parser = HarParser(json.loads(f.read()))

pages_root = har_parser.pages[0]

# Q1 - TTFB
slowest = pages_root.time_to_first_byte
fastest = pages_root.time_to_first_byte

# Q2 - duration
longest_time_to_load = pages_root.actual_page.time

initiator_dict = {}
phases_dict = {}
for page in pages_root:
    ttfb = page.timings["wait"]  # TTFB for each asset
    duration_time = page.time  # duration for each asset
    if ttfb > slowest:
        slowest = ttfb
        slowest_name = page.request.url
    if ttfb != 0 and ttfb < fastest:
        fastest = ttfb
        fastest_name = page.request.url
    if duration_time > longest_time_to_load:
        longest_time_to_load = duration_time
        longest_time_to_load_name = page.request.url
    # Q3 - initiator
    initiator = page.raw_entry['_initiator']
    if "url" in initiator:
        initiator_dict[page.request.url] = initiator['url']
    phases_dict[page.request.url] = (page.timings, page.time)

initiators = defaultdict(list)
for key, val in sorted(initiator_dict.items()):
    initiators[val].append(key)

print(f"Q1\n{slowest_name} has the slowest TTFB of {round(slowest,2)}")
print(f"{fastest_name} has the fastest TTFB of {round(fastest,2)}\n")
print(f"Q2\n{longest_time_to_load_name} resource took the longest time ({round(longest_time_to_load,2)}) to load\n")
print("Q3")
for item in initiators:
    print(f"{item} initiated the following requests: {', '.join(initiators[item])}")

print("\nQ4")
for item in phases_dict:
    item_timings = phases_dict[item][0]
    total_duration = phases_dict[item][1]
    req_resp_summary_time = item_timings['send'] + item_timings['wait'] + item_timings['receive']
    print(f"{item} spent in\n"
          f"Resource Scheduling\t {round(item_timings['_blocked_queueing'], 2)}\n"
          f"Connection Start\t {round(total_duration - req_resp_summary_time - item_timings['_blocked_queueing'], 2)}\n"
          f"Request/Response\t {round(req_resp_summary_time, 2)}\n")