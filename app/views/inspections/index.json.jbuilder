json.array!(@inspections) do |inspection|
  json.extract! inspection, :inspection_type, :unit, :tenant, :inspected_by, :inspection_date
  json.url inspection_url(inspection, format: :json)
end