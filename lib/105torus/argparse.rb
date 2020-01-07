module Torus105
    class Argparse
        attr_accessor :usage
        ARGINT = ->(x) { Integer(x) }
        def initialize(description: '')
            @description = description
            @arg_list = []
            @usage = ''
        end
        def print_usage
            puts @usage
        end
        def parse_args!(argv: ARGV)
            args = {}
            av = argv.dup

            @arg_list.each do |name, type|
                begin
                    args[name] = type.call(av.shift)
                    define_singleton_method(name) do
                        args[name]
                    end
                rescue ArgumentError
                    print_usage
                    exit(84)
                end
            end

            @args = args
        end
        def add_list(name, n, &block)
            n.times do |i|
                add_arg(:"#{name}#{i}", &block)
            end
        end
        def add_arg(name, &block)
            @arg_list.push [name, block]
        end
    end
end