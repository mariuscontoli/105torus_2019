class Polynom
    def initialize coefs
        @coefs = coefs.reverse
        @degree = coefs.length - 1
    end
    def calculate x
        i = @degree + 1
        @coefs.reduce(0) { |r, v|
            i -= 1
            r + (v*(x**i))
        }
    end
    def calculate_der x
        i = @degree + 1
        @coefs.reduce(0) { |r, v|
            i -= 1
            r + i*(v*(x**(i-1)))
        }
    end
    def newton (s: 0.5, p: 6, &block)
        case @degree
        when 4
            200.times do |i|
                xplus = s - (calculate(s) / calculate_der(s))
                return if ((xplus - s).abs / xplus.abs < 0.1**p)
                yield(s)
                s = xplus
            end
        end
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