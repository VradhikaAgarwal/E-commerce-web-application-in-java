function add_to_cart(pid,pname,price)
{
	let cart=localStorage.getItem("cart");
	if(cart == null)
	{
		//no cart yet
		let products=[];
		let product={productId:pid, productName:pname, productQuantity:1, productPrice:price}
		products.push(product);
		
		//save products in localStorage
		//here we use json.stringify method for converting array into string as localStorage returns only String
		
		localStorage.setItem("cart", JSON.stringify(products));
		//console.log("Product is added for the first time")
		showToast("Item is added to the cart")
		
	}
	else{
		//cart is already present
		
		//parsing string into javascript array
		let pcart=JSON.parse(cart);
		
		//find the old product whether it is already present or not. check by product Id
		let oldProduct=pcart.find((item) => item.productId == pid)
		
		if(oldProduct){
			
			//we only have to increase the quantity
			//if product is old product increase the quantity
			oldProduct.productQuantity = oldProduct.productQuantity+1
			
			//traverse the items in the cart and check whether old product id matches with the new item id, if yes then update the quantity
			pcart.map((item) => {
				if(item.productId == oldProduct.productId)
				{
					//update the product quantity
					item.productQuantity= oldProduct.productQuantity;
				}
			})
			//set the value in the cart
			localStorage.setItem("cart",JSON.stringify(pcart));
			//console.log("Product quantity is increased")
			showToast(oldProduct.productName+ " Quantity is increased, Quantity: " +oldProduct.productQuantity)
			
		}
		else{
			//we have to add the new product in the cart
			let product={productId:pid, productName:pname, productQuantity:1, productPrice:price}
			pcart.push(product)
			localStorage.setItem("cart", JSON.stringify(pcart));
			//console.log("Product is added")		
			showToast("Item is added to cart")
		}	
	}
	updateCart();
}
//update cart
function updateCart()
{
	let cartString=localStorage.getItem("cart");
	let cart=JSON.parse(cartString);
	if(cart==null || cart.length==0)
	{
		console.log("Cart is empty...")
		$(".cart-items").html("( 0 )");
		$(".cart-body").html("<h3>Cart does not have any item</h3>");
		$(".checkout-btn").attr('disabled',true);
	}
	else{
		//there is something to show in cart
		console.log(cart)	
		
		//show dynamic cart values when items are added by JQuery
		$(".cart-items").html(`(${cart.length})`);
		let table=`
		<table class='table'>
		<thead class='thead-light'>
		  <tr>
		     <th>Item Name</th>
		     <th>Price</th>
		     <th>Quantity</th>
		     <th>Total Price</th>
		     <th>Action</th>  
		  </tr>
		</thead>
		`;
		
		let totalPrice=0;
		cart.map((item) =>{
			
			table +=`
			     <tr>
			       <td> ${item.productName} </td>
			       <td> ${item.productPrice} </td>
			       <td> ${item.productQuantity} </td>       
			       <td> ${item.productQuantity * item.productPrice} </td>   
			       <td><button onclick='deleteItem(${item.productId})' class='btn btn-danger btn-sm'>Remove </button></td>
			     </tr>	
			
			`
			totalPrice += item.productPrice * item.productQuantity;
			
		})
		table= table + `
		<tr><td colspan='5' class='text-right font-weight-bold m-5'> Total Price : ${totalPrice} </td></tr>
		</table>`
		$(".cart-body").html(table);
		$(".checkout-btn").attr('disabled',false);
	}	
}

// delete item from cart
function deleteItem(pid)
{
	let cart=JSON.parse(localStorage.getItem('cart'));
	
	//remove the item which matches with product Id after filtering the array
	let newcart=cart.filter((item) => item.productId != pid);
	
	//set new cart
	localStorage.setItem('cart',JSON.stringify(newcart));
	updateCart();
	showToast("Item is removed from cart")
}




$(document).ready(function (){
	updateCart()
}
)

function showToast(content) {
	$("#toast").addClass("display");
	$("#toast").html(content);
	setTimeout(() => {
		$("#toast").removeClass("display");	
	},2000);	
}
function goToCheckout(){
	
	window.location="checkout.jsp"
	
}