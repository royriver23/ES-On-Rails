class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :by_ids, (lambda do |ids|
    ids_order = ids.map { |id| "id = #{id} DESC" }.join(',')
    where(id: ids)
    .order(ids_order)
  end)
end
