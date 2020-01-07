class Polynom
    def initialize coefs
        @coefs = coefs.map { |x| Float(x) }.reverse
        @degree = coefs.length - 1
    end
    def calculate x
        i = @degree + 1
        @coefs.reduce(0) { |r, v|
            i -= 1
            r + (v*(x**i))
        }
    end
    def bisection(s: 0.0, e: 1.0, p: 6, &block)
        case @degree
        when 4
            if (calculate(e) * calculate(s) <= 0)
                mid = (s + e)/2.0
                return if ((s - e).abs / (2 * mid.abs)) < 0.1**p
                yield(mid)
                bisection(s: s, e: mid, p: p, &block)
                bisection(s: mid, e: e, p: p, &block)
            end
        end
    end
end