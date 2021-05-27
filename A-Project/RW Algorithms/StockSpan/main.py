import generate_stock_span, stock_span, stack


def main() -> None:
    quotes = generate_stock_span.random_stocks(10, 10)
    print(quotes)
    # print(stock_span.simple_stock_span(quotes))
    print(stock_span.stack_stock_span(quotes))


if __name__ == '__main__':
    try:
        main()
    except Exception as ex:
        raise ex
