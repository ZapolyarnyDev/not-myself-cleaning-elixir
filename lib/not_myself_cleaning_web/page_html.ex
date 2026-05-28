defmodule NotMyselfCleaningWeb.PageHTML do
  @moduledoc false

  def home do
    """
    <!doctype html>
    <html lang="ru">
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Not Myself Cleaning</title>
        <link rel="stylesheet" href="/assets/app.css">
      </head>
      <body>
        <main class="shell">
          <section class="hero">
            <p class="eyebrow">Elixir app scaffold</p>
            <h1>Not Myself Cleaning</h1>
            <p>Базовый каркас приложения для сервиса заявок на уборку.</p>
          </section>
        </main>
      </body>
    </html>
    """
  end
end
