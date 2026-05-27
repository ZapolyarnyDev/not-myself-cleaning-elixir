defmodule NotMyselfCleaningWeb.AdminHTML do
  use NotMyselfCleaningWeb, :html

  embed_templates("admin_html/*")

  def status_labels do
    %{
      "new" => "Новая заявка",
      "in_work" => "В работе",
      "done" => "Выполнено",
      "cancelled" => "Отменено"
    }
  end
end
