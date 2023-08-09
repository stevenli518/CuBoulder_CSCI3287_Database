USE mydb;

-- Insert Data 

INSERT INTO `customer`(`customer_ID`, `customer_name`, `customer_address`, `customer_phone`, `customer_email`, `customer_DOB`) VALUES
('1', 'Elon Mask', '4156 Brannon Street', '(310)-720-6740', 'vibix70301@syinxun.com', '2004-11-25') ,
('2', 'Steven Li', '2742 Glenwood Avenue', '(494) 699-7762', 'kavkaz7777@chantellegribbon.com', '2001-01-25') ,
('3', 'Chengming Li', '820 Bel Meadow Drive', '(683) 641-6204', 'jillianoreilly@naverly.com', '1999-08-23') ,
('4', 'Lidiya Freida', '3385 Michael Street', '(424) 575-4621', '986530898@dgaga.com', '2004-01-01') ,
('5', 'Lycus Maral', '4907 Desert Broom Court', '(966) 352-2198', '49697438@syinxun.com', '1980-07-13') ;

INSERT INTO `plan`(`plan_ID`, `plan_type`, `plan_name`, `plan_duration`, `plan_cost`, `plan_features`) VALUES
('1', 'prepaid', 'prepaid-individual', '120', '9.99', '2G DATA and 120 mins phone call'),
('2', 'postpaid', 'postpaid-individual', '100', '9.99', '2G DATA and 100 mins phone call'),
('3', 'pre-paid', 'prepaid-family', '120', '69.99', 'unlimit DATA and 120 mins phone call for 7 people'),
('4', 'data-only', 'data-only-individual', '0', '19.99', 'unlimit DATA');

INSERT INTO `transaction`(`transaction_ID`, `customer_ID`, `plan_ID`, `transaction_type`, `transaction_date`, `transaction_amount`) VALUES
('1', '1', '1', 'plan activation', '2021-04-26', '9.99'),
('2', '1', '1', 'plan renewal', '2021-05-26', '9.99'),
('3', '1', '4', 'plan change', '2024-04-26', '19.99'),
('4', '2', '1', 'plan activation', '2018-01-03', '9.99'),
('5', '2', '1', 'plan renewal', '2018-02-03', '9.99'),
('6', '2', '1', 'cancellation', '2018-03-03', '0.00'),
('7', '3', '2', 'plan activation', '2020-11-09', '9.99'),
('8', '3', '2', 'plan renewal', '2020-12-10', '9.99'),
('9', '3', '3', 'plan change', '2021-01-10', '69.99'),
('10', '4', '4', 'plan activation', '2020-07-01', '19.99'),
('11', '4', '4', 'plan renewal', '2020-08-10', '19.99'),
('12', '4', '3', 'plan change', '2020-09-10', '69.99'),
('13', '5', '1', 'plan activation', '2021-04-26', '9.99'),
('14', '5', '1', 'plan renewal', '2021-05-26', '9.99'),
('15', '5', '4', 'plan change', '2021-07-26', '19.99');

INSERT INTO `customer_plan`(`customer_ID`, `plan_ID`) VALUES
('1', '1'),
('1', '4'),
('2', '1'),
('3', '2'),
('3', '3'),
('4', '3'),
('4', '4'),
('5', '1'),
('5', '4');

INSERT INTO `call_traffic`(`call_ID`, `customer_ID`, `call_date`, `call_duration`, `call_cost`,`call_type`) VALUES
('1', '1', '2015-04-26', '10', '0.00', 'local'),
('2', '1', '2018-04-26', '150', '5.00', 'local'),
('3', '1', '2023-02-26', '10', '0.00', 'national'),
('4', '2', '2015-01-06', '1', '0.00', 'local'),
('5', '2', '2018-07-26', '15', '15.00', 'international'),
('6', '2', '2020-02-13', '10', '5.00', 'national'),
('7', '3', '2015-04-09', '10', '0.00', 'local'),
('8', '3', '2018-04-26', '190', '190.00', 'international'),
('9', '3', '2019-11-16', '7', '3.50', 'national'),
('10', '4', '2019-07-26', '10', '10.00', 'international'),
('11', '4', '2019-06-28', '150', '15.00', 'local'),
('12', '4', '2020-02-26', '10', '5.00', 'national'),
('13', '5', '2021-07-26', '10', '10.00', 'international'),
('14', '5', '2021-08-08', '150', '150.00', 'international'),
('15', '5', '2021-12-16', '10', '10.00', 'international');

INSERT INTO `cancellation`(`cancellation_ID`, `customer_ID`, `cancellation_date`, `cancellation_reason`) VALUES
('1', '2', '2018-03-03', 'choose other carrier');

