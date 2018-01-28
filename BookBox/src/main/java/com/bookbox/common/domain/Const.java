package com.bookbox.common.domain;

public class Const {

	public static final int NONE = -1;

	public class Category{
		public static final int CREATION = 1;
		public static final int WRITING = 2;
		public static final int FUNDING = 3;
		public static final int BOOKLOG = 4;
		public static final int POSTING = 5;
		public static final int BOARD = 6;
		public static final int CAMCHAT = 7;
		public static final int CAST = 8;
		public static final int BOOK = 9;
		public static final int UNIFIEDSEARCH = 10;
		public static final int TAG = 11;
		public static final int BOOKCATEGORY = 12;
	}
	
	public class Behavior{
		public static final int LIST = 0;
		public static final int GET = 1;
		public static final int JOIN = 2;
		public static final int PAY = 3;
		public static final int ADD = 4;
		public static final int SEARCH = 5;
		public static final int UPDATE = 6;
		public static final int RECOMMEND = 7;
		public static final int DELETE = 8;
		public static final int ABLE = 9;
		public static final int CANCEL = 10;
	}
	
	public class AddBehavior{
		public static final int LIKE = 1;
		public static final int SUBSCRIBE = 2;
		public static final int GRADE = 3;
		public static final int BOOKMARK = 4;
		public static final int REPLY = 5;
		public static final int COMMENT = 6;
	}
	
}
