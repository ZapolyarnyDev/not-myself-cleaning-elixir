# Документация проекта

В данной директории представлена краткая документация, что организована в виде Jupyter Notebook файлов

## Содержание

### 01. Архитектура проекта
**Файл:** `01_architecture.ipynb`

Общая архитектура приложения, контекстов и схем данных

### 02. База данных
**Файл:** `02_database.ipynb`

Описание схемы базы данных, таблиц, связей и миграций

### 03. API и маршруты
**Файл:** `03_api.ipynb`

Документация всех HTTP-маршрутов, параметров запросов и ответов

### 04. Установка и развертывание
**Файл:** `04_deployment.ipynb`

Пошаговое руководство по установке, настройке и запуску проекта

### 05. Миграция с TypeScript
**Файл:** `05_migration.ipynb`

Детали миграции проекта с TypeScript/Express на Elixir/Phoenix

## Просмотр документации

### Jupyter Notebook

Для просмотра в Jupyter Notebook:

```bash
pip install notebook
jupyter notebook docs/
```

### VS Code

Установите расширение "Jupyter" для VS Code. Файлы `.ipynb` откроются автоматически

### GitHub

GitHub форматирует `.ipynb` файлы при просмотре в браузере

### Экспорт в другие форматы (HTML / PDF / Markdown)

```bash
# Установка nbconvert
pip install nbconvert

# Экспорт в HTML
jupyter nbconvert --to html docs/01_architecture.ipynb

# Экспорт в PDF
jupyter nbconvert --to pdf docs/01_architecture.ipynb

# Экспорт в Markdown
jupyter nbconvert --to markdown docs/01_architecture.ipynb
```

## Структура документации

```
docs/
├── README.md
├── 01_architecture.ipynb      # Архитектура
├── 02_database.ipynb          # База данных
├── 03_api.ipynb               # API и маршруты
├── 04_deployment.ipynb        # Развертывание
└── 05_migration.ipynb         # Миграция с TypeScript
```
