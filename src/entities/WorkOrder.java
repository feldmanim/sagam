package entities;

public class WorkOrder {
	private long serialNumber;
	private RawMaterial rawMaterial;
	private long customerId;
	private String SBP;
	private long orderBarCode;
	public long getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(long serialNumber) {
		this.serialNumber = serialNumber;
	}
	public RawMaterial getRawMaterial() {
		return rawMaterial;
	}
	public void setRawMaterial(RawMaterial rawMaterial) {
		this.rawMaterial = rawMaterial;
	}
	public long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}
	public String getSBP() {
		return SBP;
	}
	public void setSBP(String sBP) {
		SBP = sBP;
	}
	public long getOrderBarCode() {
		return orderBarCode;
	}
	public void setOrderBarCode(long orderBarCode) {
		this.orderBarCode = orderBarCode;
	}

}
