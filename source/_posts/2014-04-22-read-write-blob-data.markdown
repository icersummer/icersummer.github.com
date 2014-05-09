---
layout: post
title: "读写Blob对象-Oracle版"
date: 2014-04-22 12:26:03 -0800
comments: true
categories: [scp, linux, centos, ubuntu] 
---

在JDBC中如何Insert/Retrieve BLOB对象呢？

示例代码如下：

```

	private static void testWriteReadObjectInBlob() {
		try {
			// table blob_test : create table blob_test(id number, test blob);
			System.out.println("@testWriteReadObjectInBlob:");
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			String id = "" + 6;
			System.out.println("current id : " + id);
			String sql1 = "insert into blob_test(id, test) values ([id], empty_blob())".replace("[id]", id);
			stmt.executeUpdate(sql1);
			String sql2 = "select test from blob_test where id=[id] for update".replace("[id]", id);
			ResultSet rs = stmt.executeQuery(sql2);
			Object master = any_of_my_class_object;//TODO
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			ObjectOutputStream oos = new ObjectOutputStream(bos);
			oos.writeObject(master);
			byte[] data = bos.toByteArray();
			while(rs.next()) {
				oracle.sql.BLOB blob = (oracle.sql.BLOB)rs.getBlob("test");
				OutputStream outStream = blob.getBinaryOutputStream();
				outStream.write(data, 0, data.length);
				outStream.flush();
				outStream.close();
			}
			conn.commit();
			
			//read out
			String sql3 = "select * from blob_test where id=[id]".replace("[id]", id);
			rs = stmt.executeQuery(sql3);
			while(rs.next()) {
				byte[] byteBuffer = rs.getBytes("test");
				ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(byteBuffer);
				ObjectInputStream objectInputStream = new ObjectInputStream(byteArrayInputStream);
				Object obj = objectInputStream.readObject();
				System.out.println("--------------------");
				System.out.println(obj);
				System.out.println("--------------------");
				System.out.println(obj.getClass().getName());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
```

参考链接：

1. Inserting BLOB data through JDBC [link](http://www.go4expert.com/forums/inserting-blob-data-jdbc-t866/);
2. I get good answer in this SOF post [link](http://stackoverflow.com/questions/8348427/how-to-write-update-oracle-blob-in-a-reliable-way);
3. 洛显臃肿的多种BLOB读值方式：Store Precedure、DBMS_LOB、Oracle Blob：[link](http://blog.csdn.net/yanghongchang_/article/details/7644115)
4. Reading a blob from MySQL [link](http://stackoverflow.com/questions/14610011/reading-a-blob-from-mysql-with-java);


另note：

1. Oracle中blob类型为blob；
2. SqlServer中blob类型为image。