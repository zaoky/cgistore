create database if not exists store_lab;

use store_lab;

create table if not exists user (
    user_id int not null AUTO_INCREMENT,
    username varchar(50) not null,
    email varchar(50) not null,
    password varchar(50),
    entry_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    constraint pk_user primary key(user_id),
    constraint uk_user_username UNIQUE (username),
    constraint uk_user_email UNIQUE (email)
);

create table if not exists product (
    product_id int not null AUTO_INCREMENT,
    user_id int not null,
    code varchar(25) not null,
    entry_date datetime not null default current_timestamp,
descr varchar(100),
price decimal(13,2),
image_path varchar(1024),
    constraint pk_product primary key(product_id),
    constraint uk_product_code UNIQUE (code),
CONSTRAINT fk_product FOREIGN KEY (product_id)
      REFERENCES user(user_id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
);

create table if not exists shopping_cart (
    user_id int not null,
    product_id int not null,
    quantity decimal(13,2) default 0,
    constraint pk_shopping_cart primary key (user_id, product_id),
    constraint fk_shopping_cart_user_id foreign key (user_id) references user(user_id) 
on delete RESTRICT
    on update RESTRICT,
    constraint fk_shopping_cart_product_id foreign key (product_id) references product(product_id)
    on delete RESTRICT
    on update RESTRICT
);


create table if not exists suggestion (
    suggestion_id int not null AUTO_INCREMENT,
    user_id int null,
    entry_date datetime not null default current_timestamp,
reason varchar(100),
message varchar(300),
name varchar(50),
email varchar(50),
    constraint pk_suggestion primary key(suggestion_id),
CONSTRAINT fk_suggestion FOREIGN KEY (suggestion_id)
      REFERENCES user(user_id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
);

create table if not exists invoice_header (
    invoice_no int not null AUTO_INCREMENT,
    user_id int not null,
    entry_date datetime not null default current_timestamp,
descr varchar(100),
subtotal decimal(13,2),
taxes decimal(13,2),
total decimal(13,2),
    constraint pk_invoice_header primary key(invoice_no),
CONSTRAINT fk_invoice_headern FOREIGN KEY (invoice_no)
      REFERENCES user(user_id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
);

create table if not exists invoice_detail (
    invoice_detail_id int not null,
    invoice_no int not null,
product_id int not null,
descr varchar(100),
    quantity decimal(13,2),
price decimal(13,2),
discount decimal(13,2),
    constraint pk_invoice_detail primary key (invoice_detail_id),
    constraint fk_invoice_detail_invoice_no foreign key (invoice_detail_id) references invoice_header(invoice_no) 
on delete RESTRICT
    on update RESTRICT,
    constraint fk_invoice_detail_product_id foreign key (invoice_detail_id) references product(product_id)
    on delete RESTRICT
    on update RESTRICT
);

CREATE USER 'cgistore'@'localhost' IDENTIFIED BY 'M2rI.DB_C';
GRANT SELECT,INSERT,UPDATE,DELETE ON store_lab.user TO 'cgistore'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON store_lab.product TO 'cgistore'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON store_lab.shopping_cart TO 'cgistore'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON store_lab.suggestion TO 'cgistore'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON store_lab.invoice_header TO 'cgistore'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON store_lab.invoice_detail TO 'cgistore'@'localhost';