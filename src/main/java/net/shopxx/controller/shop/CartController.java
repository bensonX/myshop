/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.shopxx.Message;
import net.shopxx.entity.Cart;
import net.shopxx.entity.CartItem;
import net.shopxx.entity.Goods;
import net.shopxx.entity.Member;
import net.shopxx.entity.Product;
import net.shopxx.service.CartItemService;
import net.shopxx.service.CartService;
import net.shopxx.service.MemberService;
import net.shopxx.service.ProductService;
import net.shopxx.util.JsonUtils;
import net.shopxx.util.WebUtils;

/**
 * Controller - 购物车
 * 
 * @author JSHOP Team \* @version 3.X
 */
@Controller("shopCartController")
@RequestMapping("/cart")
public class CartController extends BaseController {

	@Resource(name = "memberServiceImpl")
	private MemberService memberService;
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	@Resource(name = "cartServiceImpl")
	private CartService cartService;
	@Resource(name = "cartItemServiceImpl")
	private CartItemService cartItemService;

	/**
	 * 数量
	 */
	@RequestMapping(value = "/quantity", method = RequestMethod.GET)
	public @ResponseBody Map<String, Integer> quantity() {
		Map<String, Integer> data = new HashMap<String, Integer>();
		Cart cart = cartService.getCurrent();
		data.put("quantity", cart != null ? cart.getProductQuantity() : 0);
		return data;
	}

	/**
	 * 添加
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public @ResponseBody Message add(Long productId, Integer quantity, HttpServletRequest request, HttpServletResponse response) {
		if (quantity == null || quantity < 1) { return ERROR_MESSAGE; }
		Product product = productService.find(productId);
		if (product == null) { return Message.warn("shop.cart.productNotExist"); }
		if (!Goods.Type.general.equals(product.getType())) { return Message.warn("shop.cart.productNotForSale"); }
		if (!product.getIsMarketable()) { return Message.warn("shop.cart.productNotMarketable"); }

		Cart cart = cartService.getCurrent();
		if (cart != null) {
			if (cart.contains(product)) {
				CartItem cartItem = cart.getCartItem(product);
				if (CartItem.MAX_QUANTITY != null && cartItem.getQuantity() + quantity > CartItem.MAX_QUANTITY) { return Message.warn("shop.cart.addQuantityNotAllowed", CartItem.MAX_QUANTITY); }
				if (cartItem.getQuantity() + quantity > product.getAvailableStock()) { return Message.warn("shop.cart.productLowStock"); }
			} else {
				if (Cart.MAX_CART_ITEM_COUNT != null && cart.getCartItems().size() >= Cart.MAX_CART_ITEM_COUNT) { return Message.warn("shop.cart.addCartItemCountNotAllowed", Cart.MAX_CART_ITEM_COUNT); }
				if (CartItem.MAX_QUANTITY != null && quantity > CartItem.MAX_QUANTITY) { return Message.warn("shop.cart.addQuantityNotAllowed", CartItem.MAX_QUANTITY); }
				if (quantity > product.getAvailableStock()) { return Message.warn("shop.cart.productLowStock"); }
			}
		} else {
			if (CartItem.MAX_QUANTITY != null && quantity > CartItem.MAX_QUANTITY) { return Message.warn("shop.cart.addQuantityNotAllowed", CartItem.MAX_QUANTITY); }
			if (quantity > product.getAvailableStock()) { return Message.warn("shop.cart.productLowStock"); }
		}
		cart = cartService.add(product, quantity);

		Member member = memberService.getCurrent();
		if (member == null) {
			WebUtils.addCookie(request, response, Cart.KEY_COOKIE_NAME, cart.getKey(), Cart.TIMEOUT);
		}
		return Message.success("shop.cart.addSuccess", cart.getProductQuantity(), currency(cart.getEffectivePrice(), true, false));
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(ModelMap model) {
		Cart cart = cartService.getCurrent();
		model.addAttribute("cart", cart);
		return "/shop/${theme}/cart/list_mdh";
	}

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getCartData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getCartData() {
		Map<String, Object> data = new HashMap<String, Object>();
		List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();
		data.put("cart", cartList);
		Cart cart = cartService.getCurrent();
		if (cart == null) {
			data.put("message", new Message(Message.Type.error, "购物车为空"));
			return data;
		}
		Set<CartItem> cartItemsSet = cart.getCartItems();
		if (cartItemsSet == null || cartItemsSet.size() < 0) {
			data.put("message", new Message(Message.Type.error, "购物车为空"));
			return data;
		}
		for (CartItem cartItem : cartItemsSet) {
			Map<String, Object> cartItems = new HashMap<String, Object>();
			Product product = cartItem.getProduct();
			Goods goods = product.getGoods();
			cartItems.put("quantity", cartItem.getQuantity());
			cartItems.put("cartItem.id", cartItem.getId());
			cartItems.put("cartItem.price", cartItem.getComprehensivePrice());
			cartItems.put("product.sn", product.getSn());
			cartItems.put("product.url", product.getUrl());
			cartItems.put("product.thumbnail", product.getThumbnail());
			cartItems.put("product.specifications", JsonUtils.toJson(product.getSpecifications()));
			cartItems.put("product.goods.image", goods.getImage());
			cartItems.put("product.goods.name", goods.getName());
			cartList.add(cartItems);
		}
		data.put("message", SUCCESS_MESSAGE);
		return data;
	}

	/**
	 * 编辑
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edit(Long id, Integer quantity) {
		Map<String, Object> data = new HashMap<String, Object>();
		if (quantity == null || quantity < 1) {
			data.put("message", ERROR_MESSAGE);
			return data;
		}
		Cart cart = cartService.getCurrent();
		if (cart == null || cart.isEmpty()) {
			data.put("message", Message.error("shop.cart.notEmpty"));
			return data;
		}
		CartItem cartItem = cartItemService.find(id);
		if (!cart.contains(cartItem)) {
			data.put("message", Message.error("shop.cart.cartItemNotExist"));
			return data;
		}
		if (CartItem.MAX_QUANTITY != null && quantity > CartItem.MAX_QUANTITY) {
			data.put("message", Message.warn("shop.cart.addQuantityNotAllowed", CartItem.MAX_QUANTITY));
			return data;
		}
		Product product = cartItem.getProduct();
		if (quantity > product.getAvailableStock()) {
			data.put("message", Message.warn("shop.cart.productLowStock"));
			return data;
		}
		cartItem.setQuantity(quantity);
		cartItemService.update(cartItem);

		data.put("message", SUCCESS_MESSAGE);
		data.put("subtotal", cartItem.getSubtotal());
		data.put("isLowStock", cartItem.getIsLowStock());
		data.put("quantity", cart.getProductQuantity());
		data.put("effectiveRewardPoint", cart.getEffectiveRewardPoint());
		data.put("effectivePrice", cart.getEffectivePrice());
		data.put("giftNames", cart.getGiftNames());
		data.put("promotionNames", cart.getPromotionNames());
		return data;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> delete(Long id) {
		Map<String, Object> data = new HashMap<String, Object>();
		Cart cart = cartService.getCurrent();

		if (cart == null || cart.isEmpty()) {
			data.put("message", Message.error("shop.cart.notEmpty"));
			return data;
		}
		CartItem cartItem = cartItemService.find(id);
		if (!cart.contains(cartItem)) {
			data.put("message", Message.error("shop.cart.cartItemNotExist"));
			return data;
		}
		cartItemService.delete(cartItem);
		cart.getCartItems().remove(cartItem);

		data.put("message", SUCCESS_MESSAGE);
		data.put("isLowStock", cart.getIsLowStock());
		data.put("quantity", cart.getProductQuantity());
		data.put("effectiveRewardPoint", cart.getEffectiveRewardPoint());
		data.put("effectivePrice", cart.getEffectivePrice());
		data.put("giftNames", cart.getGiftNames());
		data.put("promotionNames", cart.getPromotionNames());
		return data;
	}

	/**
	 * 清空
	 */
	@RequestMapping(value = "/clear", method = RequestMethod.POST)
	public @ResponseBody Message clear() {
		Cart cart = cartService.getCurrent();
		cartService.delete(cart);
		return SUCCESS_MESSAGE;
	}

}