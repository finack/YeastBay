def batches
  @items.select { |item| item[:kind] == 'batch' }
end

def sorted_batches
  batches.sort_by { |b| b[:id] }.reverse
end