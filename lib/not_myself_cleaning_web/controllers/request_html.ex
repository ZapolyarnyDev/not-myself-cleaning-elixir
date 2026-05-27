defmodule NotMyselfCleaningWeb.RequestHTML do
  use NotMyselfCleaningWeb, :html

  embed_templates("request_html/*")

  def services do
    [
      "Поддерживающая уборка",
      "Генеральная уборка",
      "Уборка после ремонта",
      "Химчистка ковров и мебели"
    ]
  end

  def payments do
    ["Наличные", "Банковская карта"]
  end

  def status_labels do
    %{
      "new" => "Новая заявка",
      "in_work" => "В работе",
      "done" => "Выполнено",
      "cancelled" => "Отменено"
    }
  end
end
