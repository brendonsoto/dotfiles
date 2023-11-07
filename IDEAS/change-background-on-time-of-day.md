# Change the background color based on the time of day 
  I used to use this for a while but removed it as I liked the dark screen more.
  Here's the snippet (with `chezmoi`)

  ``` lua
  {{ if not .force_dark -}}
  -- Set background depending on time of day
  -- This is mostly to hint to me that it's time to go home / stop working
  local current_hour = tonumber(os.date("%H", os.time()))
  local starting_light_hour = 9
  local starting_dark_hour = 12 + 5 -- to use 24 hours
  local is_day_time = starting_light_hour <= current_hour and current_hour < starting_dark_hour

  if (is_day_time) then
    set.background = "light"
  else
    set.background = "dark"
  end
  {{- else -}}
  set.background = "dark"
  {{- end }}
  ```
