from typing import List

from faker import Faker


def random_stocks(number_of_days, maximum) -> List[int]:
    fake = Faker()
    stocks = []
    for _ in range(number_of_days):
        stocks.append(fake.pyint(min_value=0, max_value=maximum))
    return stocks


