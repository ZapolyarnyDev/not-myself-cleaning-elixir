# not-myself-cleaning-elixir

Учебная практика: Elixir-приложение для сайта клининговой компании.

## Стек

- Elixir / OTP
- Plug + Cowboy
- Ecto SQL
- Postgrex
- PostgreSQL
- Nix + Just

## Что уже есть

- OTP application supervisor;
- базовый HTTP router;
- стартовая HTML-страница;
- `GET /health` для проверки статуса;
- подготовленный `Ecto.Repo` для PostgreSQL;
- тесты роутера.

## Локальный запуск

1. Зайдите в dev shell:

```sh
nix develop
```

2. Установите зависимости:

```sh
just setup
```

3. При необходимости поднимите локальную базу:

```sh
just db-init
just db-start
```

4. Запустите приложение:

```sh
just server
```

После запуска приложение будет доступно по адресу `http://localhost:4000`.

## Команды

- `just setup` - установка Mix-зависимостей;
- `just format` - форматирование Elixir-кода;
- `just test` - запуск тестов;
- `just check` - форматирование в check-режиме и тесты;
- `just server` - запуск приложения;
- `just db-init` - инициализация PostgreSQL в `.data/postgres`;
- `just db-start` - запуск локального PostgreSQL;
- `just db-stop` - остановка локального PostgreSQL;
- `just db-reset` - пересоздание локального PostgreSQL.
