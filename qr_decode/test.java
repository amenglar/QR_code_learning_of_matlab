import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.BarcodeFormat;

putlic class test {
	public static void main(String args[]){
		String message = "www.baidu.com";
		qr_writer = QRCodeWriter;
		M_java = qr_writer.encode(message, BarcodeFormat.QR_CODE, 256, 256);
		int qr(M_java.height, M_java.width) = 0;
		//qr = zeros(M_java.height, M_java.width);
		//for i=1:M_java.height
    	//	for j=1:M_java.width
        //		qr(i,j) = M_java.get(j-1,i-1);
    	//	end
		//end
		for(i=1;i<=M_java.height;i++) {
			for(j=1;j<=M_java.width;j++) {
				qr(i,j) = M_java.get(j-1,i-1);
			}
		}

		qr = logical(qr);
	}
}