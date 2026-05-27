const moscowZone = "Europe/Moscow";
const timeSlots = ["09:00", "11:00", "13:00", "15:00", "17:00", "19:00"];

const pad = (value) => String(value).padStart(2, "0");
const isoDate = (date) => `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}`;
const isoDateTime = (date, time) => `${isoDate(date)}T${time}`;
const startOfDay = (date) => new Date(date.getFullYear(), date.getMonth(), date.getDate());

function moscowToday() {
  const parts = new Intl.DateTimeFormat("ru-RU", {
    timeZone: moscowZone,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(new Date());

  const values = Object.fromEntries(parts.map((part) => [part.type, part.value]));
  return new Date(Number(values.year), Number(values.month) - 1, Number(values.day));
}

function parseStoredValue(value) {
  const match = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}:\d{2})/.exec(value || "");

  if (!match) {
    return { date: null, time: "" };
  }

  return {
    date: new Date(Number(match[1]), Number(match[2]) - 1, Number(match[3])),
    time: match[4],
  };
}

function formatMonth(date) {
  return new Intl.DateTimeFormat("ru-RU", { month: "long", year: "numeric" }).format(date);
}

function formatSelected(date, time) {
  const day = new Intl.DateTimeFormat("ru-RU", {
    day: "numeric",
    month: "long",
    year: "numeric",
  }).format(date);

  return `${day}, ${time} МСК`;
}

function daysInMonth(year, month) {
  return new Date(year, month + 1, 0).getDate();
}

function mondayFirstOffset(date) {
  return (date.getDay() + 6) % 7;
}

function initDatePicker(root) {
  const form = root.closest("form");
  const input = root.querySelector('input[name="dateTime"]');
  const monthLabel = root.querySelector("[data-month-label]");
  const prevButton = root.querySelector("[data-month-prev]");
  const nextButton = root.querySelector("[data-month-next]");
  const daysNode = root.querySelector("[data-calendar-days]");
  const slotsNode = root.querySelector("[data-time-slots]");
  const valueNode = root.querySelector("[data-date-picker-value]");
  const errorNode = root.querySelector("[data-date-picker-error]");
  const initial = parseStoredValue(root.dataset.initialValue);

  const minDate = startOfDay(new Date(moscowToday().getTime() + 24 * 60 * 60 * 1000));
  const maxDate = startOfDay(new Date(minDate.getTime() + 30 * 24 * 60 * 60 * 1000));
  let visibleMonth = new Date(minDate.getFullYear(), minDate.getMonth(), 1);
  let selectedDate = initial.date;
  let selectedTime = timeSlots.includes(initial.time) ? initial.time : "";

  if (!selectedDate || selectedDate < minDate || selectedDate > maxDate) {
    selectedDate = null;
    selectedTime = "";
    input.value = "";
  } else {
    visibleMonth = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1);
  }

  function isDisabled(date) {
    return date < minDate || date > maxDate;
  }

  function sameDate(left, right) {
    return left && right && isoDate(left) === isoDate(right);
  }

  function syncValue() {
    const hasValue = selectedDate && selectedTime;
    input.value = hasValue ? isoDateTime(selectedDate, selectedTime) : "";
    valueNode.textContent = hasValue ? formatSelected(selectedDate, selectedTime) : "Не выбрано";
    errorNode.hidden = true;
  }

  function renderCalendar() {
    daysNode.replaceChildren();
    monthLabel.textContent = formatMonth(visibleMonth);

    const firstDay = new Date(visibleMonth.getFullYear(), visibleMonth.getMonth(), 1);
    const offset = mondayFirstOffset(firstDay);
    const totalDays = daysInMonth(visibleMonth.getFullYear(), visibleMonth.getMonth());

    for (let i = 0; i < offset; i += 1) {
      daysNode.append(document.createElement("span"));
    }

    for (let day = 1; day <= totalDays; day += 1) {
      const date = new Date(visibleMonth.getFullYear(), visibleMonth.getMonth(), day);
      const button = document.createElement("button");
      button.type = "button";
      button.className = "date-picker__day";
      button.textContent = String(day);
      button.disabled = isDisabled(date);
      button.setAttribute("aria-label", new Intl.DateTimeFormat("ru-RU", {
        day: "numeric",
        month: "long",
        year: "numeric",
      }).format(date));

      if (sameDate(date, selectedDate)) {
        button.classList.add("is-selected");
      }

      button.addEventListener("click", () => {
        selectedDate = date;
        renderCalendar();
        syncValue();
      });

      daysNode.append(button);
    }

    prevButton.disabled = visibleMonth <= new Date(minDate.getFullYear(), minDate.getMonth(), 1);
    nextButton.disabled = visibleMonth >= new Date(maxDate.getFullYear(), maxDate.getMonth(), 1);
  }

  function renderSlots() {
    slotsNode.replaceChildren();

    for (const slot of timeSlots) {
      const button = document.createElement("button");
      button.type = "button";
      button.className = "time-slot";
      button.textContent = slot;

      if (slot === selectedTime) {
        button.classList.add("is-selected");
      }

      button.addEventListener("click", () => {
        selectedTime = slot;
        renderSlots();
        syncValue();
      });

      slotsNode.append(button);
    }
  }

  prevButton.addEventListener("click", () => {
    visibleMonth = new Date(visibleMonth.getFullYear(), visibleMonth.getMonth() - 1, 1);
    renderCalendar();
  });

  nextButton.addEventListener("click", () => {
    visibleMonth = new Date(visibleMonth.getFullYear(), visibleMonth.getMonth() + 1, 1);
    renderCalendar();
  });

  form.addEventListener("submit", (event) => {
    if (input.value) {
      return;
    }

    event.preventDefault();
    errorNode.hidden = false;
    root.scrollIntoView({ behavior: "smooth", block: "center" });
  });

  renderCalendar();
  renderSlots();
  syncValue();
}

document.querySelectorAll("[data-date-picker]").forEach(initDatePicker);
