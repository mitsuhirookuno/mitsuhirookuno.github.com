# 複数形のルールを無効化
module ActiveResource
  class UnPluralizeBase < ActiveResource::Base
    class << self
      def collection_name
        @collection_name ||= element_name
      end
    end
  end
end
