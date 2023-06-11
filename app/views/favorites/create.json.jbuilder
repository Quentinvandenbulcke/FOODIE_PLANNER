
if @favorite.persisted?
  json.inserted_icon render(partial: "favorites/icon_fill", formats: :html)
else
  json.form render(partial: "favorites/icon_empty", formats: :html)
end
