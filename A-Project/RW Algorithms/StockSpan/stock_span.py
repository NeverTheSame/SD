from typing import List
import stack


def simple_stock_span(quotes) -> List[int]:
    """O(n^2)"""
    spans = []
    for day_index in range(len(quotes)):
        number_of_days_with_highest_value = 1
        span_end = False
        while day_index - number_of_days_with_highest_value >= 0 and not span_end:
            if quotes[day_index - number_of_days_with_highest_value] <= quotes[day_index]:
                number_of_days_with_highest_value += 1
            else:
                span_end = True
        spans.append(number_of_days_with_highest_value)
    return spans


def stack_stock_span(quotes) -> List[int]:
    spans = []
    quotes_stack = stack.Stack()
    # the price of the stock in the first day is not lower than the price in the first day,
    # so we push zero, the index of the first day, in the stack.
    quotes_stack.push(0)
    for day_index in range(len(quotes)):
        # print(quotes[quotes_stack.top.data])
        while not quotes_stack.is_stack_empty() and quotes[quotes_stack.top.data] <= quotes[day_index]:
            quotes_stack.pop()
        if quotes_stack.is_stack_empty():
            spans.append(day_index + 1)
        else:
            spans.append(day_index - quotes_stack.top.data)
        quotes_stack.push(day_index)
    return spans
