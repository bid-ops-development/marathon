module Marathon
  module DSL
    # wrap a simple command directly
    def uses(*tools)
      tools.each do |tool|
        define_method(tool) do |command|
          run "#{tool} #{command}"
        end
      end
    end
  end
end
