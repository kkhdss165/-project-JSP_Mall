//제품 테이블
CREATE TABLE IF NOT EXISTS product(
	p_id VARCHAR(10) NOT NULL,
	p_name VARCHAR(20) NOT NULL,
	p_unitPrice INTEGER,
	p_description TEXT,
	p_category VARCHAR(20),
	p_sales LONG,
	p_gpa double,
	p_fileName VARCHAR(20),
	PRIMARY KEY (p_id)
)default CHARSET=utf8;

//재고 테이블
CREATE TABLE IF NOT EXISTS stock(
	p_id VARCHAR(10) NOT NULL,
	p_size int NOT NULL,
	p_unitsInStock LONG,
	PRIMARY KEY (p_id,p_size)
)default CHARSET=utf8;

//회원 테이블
CREATE TABLE IF NOT EXISTS member(
	id VARCHAR(10) NOT NULL,
	password VARCHAR(10) NOT NULL,
	name VARCHAR(20) NOT NULL,
	mail VARCHAR(30),
	phone VARCHAR(20),
	address VARCHAR(90),
	regist_day VARCHAR(50),
	PRIMARY KEY (id)
)default CHARSET=utf8;

//주문 테이블
CREATE TABLE IF NOT EXISTS odr(
	o_id VARCHAR(40) NOT NULL,
	id VARCHAR(10) NOT NULL,
	p_id VARCHAR(10) NOT NULL,
	p_size int NOT NULL,
	p_quantity int NOT NULL,
	p_amount int NOT NULL,
	p_review text,
	p_score int NOT NULL,
	PRIMARY KEY (o_id,id,p_id,p_size)
)default CHARSET=utf8;