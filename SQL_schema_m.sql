-- Drops any previous loaded tables of this kind
DROP TABLE IF EXISTS review;

CREATE TABLE review (
  id INT(11) NOT NULL AUTO_INCREMENT,
  cust_id int(11) DEFAULT NULL,
  order_id int(11) DEFAULT NULL,
  restaurant_id int(11) DEFAULT NULL,
  food_quality INT(11) CHECK(food_quality BETWEEN 0 AND 5),
  food_q_comment VARCHAR(100) DEFAULT NULL,
  rider_id int(11) DEFAULT NULL,
  delivery_rating INT(11) CHECK(delivery_rating BETWEEN 0 AND 5),
  delivery_comment VARCHAR(100) DEFAULT NULL,
  satisfaction INT(11) CHECK(satisfaction BETWEEN 0 AND 5),
  sat_comment VARCHAR(100) DEFAULT NULL,
  review_date DATE DEFAULT NULL,
  PRIMARY KEY (id),
  KEY cust_id (cust_id),
  KEY order_id (order_id),
  KEY restaurant_id (restaurant_id),
  KEY rider_id (rider_id),
  CONSTRAINT review_fk_1 FOREIGN KEY (cust_id) REFERENCES `users` (id),
  CONSTRAINT review_fk_2 FOREIGN KEY (order_id) REFERENCES orders (id),
  CONSTRAINT review_fk_3 FOREIGN KEY (restaurant_id) REFERENCES restaurant (id),
  CONSTRAINT review_fk_4 FOREIGN KEY (rider_id) REFERENCES rider (id)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latina1;

--In case we want to make avarage rating an attribute of a restaurant
--The code below inserts an avarage rating score to the corresponding restaurant or delivery rider derived from the review table, where the accepted reviews are specified by the timeframe from the prompt.
INSERT INTO restaurant (monthly_rating) SELECT avg(restaurant_rating) FROM restaurant JOIN review ON restaurant.id=review.restaurant_id JOIN orders ON orders.id=review.order_id WHERE 4 >= DATEDIFF(week, review.date, GETDATE() );
INSERT INTO rider (rating) SELECT avg(delivery_rating) FROM rider JOIN review ON rider.id=review.rider_id JOIN orders ON orders.id=review.order_id WHERE 10 >= DATEDIFF(day, review.date, GETDATE() );

--This statement prints the summary for the avarage ratings for a specific restaurant
SELECT avg(restaurant_rating) FROM restaurant JOIN review ON restaurant.id=review.restaurant_id JOIN orders ON orders.id=review.order_id WHERE 4 >= DATEDIFF(week, review.date, GETDATE() );
--This statement prints the summary for the avarage ratings for a rider rider
SELECT avg(delivery_rating) FROM rider JOIN review ON rider.id=review.rider_id JOIN orders ON orders.id=review.order_id WHERE 10 >= DATEDIFF(day, review.date, GETDATE() );


-- Inserting values into review chart
INSERT INTO review VALUES (1, 1177, 65, 120, 5,'Very good food!',165, 4, NULL, 5,'Always glad to order from here','2021-11-01');
INSERT INTO review VALUES (2, 222, 66, 298, 2, 'Did not taste great', 302, 4,'Pretty fast delivery', 3, NULL, '2021-11-15');
INSERT INTO review VALUES (3, 2372, 67, 292,5,'Great food', 282, 5,'Very fast delivery', 5, 'Great overall experience','2021-11-21');
INSERT INTO review VALUES (4, 1664, 68, 127, 1, NULL, 380, 1, NULL, 1, NULL,'2021-11-24';
INSERT INTO review VALUES (5, 1210, 69, 114, 4, NULL, 188, 4,'Kind and fast delivery',4, 'Good Experience', '2021-11-04');
INSERT INTO review VALUES (6, 1666, 70, 62, 5, 'Nice meal', 288, 2, 'Took very long', 4, NULL, '2021-11-08');
INSERT INTO review VALUES (7, 1436, 71, 177, NULL, NULL, 95, NULL, NULL, NULL, NULL, '2021-11-14');
INSERT INTO review VALUES (8, 345, 72, 200, 3, NULL,210,5,'Fast',5,'Good','2021-11-17');
INSERT INTO review VALUES (9, 1675, 73, 50, 5,'Great food',19, 3, NULL, 3,'Fun time','2021-11-23');
INSERT INTO review VALUES (10, 1882, 74, 162,1,'Bad quality',279,1,'Slow',1, 'Not happy','2021-11-12');
INSERT INTO review VALUES (11, 2329, 75, 100, 5, 'Liked the meal a lot',167, 4, 'Pretty fast delivery', 5,' Overall great!','2021-11-24');
INSERT INTO review VALUES (12, 831, 77, 289,3, NULL,60,2, 'Slow',NULL,NULL,'2021-11-18');
