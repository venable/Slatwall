<!---

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

--->


<cfparam name="rc.order" type="any" />
<cfparam name="rc.orderID" type="string" />
<cfparam name="rc.orderNumber" type="string" />

<cfoutput>
	<div class="svoorderdetail">
		
		<cfif (rc.orderNumber neq "" or rc.orderID neq "") and rc.order.isNew()>
			<p class="error">The order details that you have requested either can't be found in our system, or your account doesn't have access to those order details.</p>
		</cfif>
		<cfif rc.order.isNew()>
			<form action="?nocache=1">
			<p>Look up your order status</p>
			<dl>
				<dt>Order Number</dt>
				<dd><input name="orderNumber" value="#rc.orderNumber#" /></dd>
				<dt>Last Name on Order</dt>
				<dd><input name="lastName" value="#rc.lastName#" /></dd>
				<dt>Email Address on Order</dt>
				<dd><input name="emailAddress" value="#rc.emailAddress#" /></dd>
			</dl>
			<button type="submit">Find Order</button>
			</form>
		<cfelse>
			<dl>
				<cf_SlatwallPropertyDisplay object="#rc.order#" property="OrderNumber">
				<cf_SlatwallPropertyDisplay object="#rc.order.getOrderStatusType()#" title="#rc.$.Slatwall.rbKey('entity.order.orderStatusType')#" property="Type">
				<cf_SlatwallPropertyDisplay object="#rc.order#" property="orderOpenDateTime">
				<cf_SlatwallPropertyDisplay object="#rc.order#" property="total">
			</dl>
			<table>
				<tr>
					<th>#$.slatwall.rbKey("entity.sku.skucode")#</th>
					<th class="varWidth">#$.slatwall.rbKey("entity.product.brand")# - #$.slatwall.rbKey("entity.product.productname")#</th>
					<th>#$.slatwall.rbKey("entity.orderitem.price")#</th>
					<th>#$.slatwall.rbKey("entity.orderitem.quantity")#</th>
					<th>#$.slatwall.rbKey("define.quantityshipped")#</th>
					<th>#$.slatwall.rbKey("entity.orderitem.extendedprice")#</th>
				</tr>
				<cfloop array="#rc.order.getOrderItems()#" index="local.orderItem">
					<tr>
						<td>#local.orderItem.getSku().getSkuCode()#</td>
						<td class="varWidth"><cfif Not isNull(local.orderItem.getSku().getProduct().getBrand())>#local.orderItem.getSku().getProduct().getBrand().getBrandName()# </cfif>#local.orderItem.getSku().getProduct().getProductName()#</td>
						<td>#local.orderItem.getFormattedValue('price', 'currency')#</td>
						<td>#int(local.orderItem.getQuantity())#</td>
						<td>#local.orderItem.getQuantityDelivered()#</td>
						<td>#local.orderItem.getFormattedValue('extendedPrice', 'currency')#</td>
					</tr>
				</cfloop>
			</table>
		</cfif>
	</div>
</cfoutput>