package dto;

import java.io.Serializable;

public class Product implements Serializable {
	
	private static final long serialVersionUID = - 4274700572038677000L;
	
	private String productID;		//상품 아이디
	private int size;				//사이즈
	private long quantity;			//장바구니에 담은 개수

	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Product(String productID, int size, long quantity) {
		super();
		this.productID = productID;
		this.size = size;
		this.quantity = quantity;
	}
	public String getProductID() {
		return productID;
	}
	public void setProductID(String productID) {
		this.productID = productID;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public long getQuantity() {
		return quantity;
	}
	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}
	
}
