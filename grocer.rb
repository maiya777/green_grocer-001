def consolidate_cart(cart:[])
  cart.each_with_object({}) {|item, cons| counter = cart.count(item)
  item.each {|key, value| cons[key] = value
  value[:count] = counter}
  }
end

def apply_coupons(cart:[], coupons:[])
  coupons_cart = {}
  coupons.each {|coupon| cart.collect {|key, value|
    if (coupon[:item] == key)&&(value[:count]>=coupon[:num])
      value[:count] -= coupon[:num]

      if coupons_cart.has_key?(key.to_s + " W/COUPON")
        coupons_cart[key.to_s + " W/COUPON"][:count] +=1

      else coupons_cart[key.to_s + " W/COUPON"] = {:price => coupon[:cost], :clearance => value[:clearance], :count => 1}
      end
     end
    }
  }
  #cart.delete_if {|key, value| value[:count] == 0}
  cart.merge(coupons_cart)# code here
end

def apply_clearance(cart:[])
  cart.each_value {|value| if value[:clearance] == true
    value[:price] = (0.8*value[:price]).round(2)
  end
  }# code here
end

def checkout(cart:[], coupons:[])
  total = 0.0
  consolidated = consolidate_cart(cart:cart)
  with_coupons = apply_coupons(cart:consolidated, coupons:coupons)
  clearance = apply_clearance(cart:with_coupons)
  clearance.each_value {|value| total += value[:price]*value[:count]}
  if total > 100
    total *= 0.9
  end
  total.round(2)
end

