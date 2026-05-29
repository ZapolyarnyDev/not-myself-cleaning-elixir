# Быстрый старт

## Минимальная установка

```bash
# 1. Клонировать репозиторий
git clone <repository-url>
cd not-myself-cleaning-elixir

# 2. Настроить окружение
cp .env.example .env

# 3. Полная инициализация (одна команда)
just init

# 4. Запустить сервер
just server
```

Откройте http://localhost:4000

## Основные команды

```bash
just                # Показать все команды
just init           # Полная инициализация
just server         # Запустить сервер
just console        # Сервер с консолью
just check          # Проверка и тесты
just routes         # Показать маршруты
```

## Тестовые данные

**Администратор:**
- Логин: `adminka`
- Пароль: `password`

## Документация

Полная документация в `docs/`:
- `01_architecture.ipynb` - архитектура
- `02_database.ipynb` - база данных
- `03_api.ipynb` - API и маршруты
- `04_deployment.ipynb` - развертывание
- `05_migration.ipynb` - миграция с TypeScript

## Возможные проблемы

### PostgreSQL не запущен
```bash
sudo systemctl start postgresql
```

### Порт 4000 занят
Измените `PORT` в `.env`

### Elixir не установлен
https://elixir-lang.org/install.html
