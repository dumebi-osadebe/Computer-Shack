
%%%%% Atomic propositions for a product
product(macbook_pro, apple, laptop, 2400, 4.0).
product(macbook_air, apple, laptop, 1700, 4.8).
product(microsoft_surface_go, microsoft, laptop, 1500, 3.6).
product(lenovo_thinkpad, lenovo, laptop, 1400, 4.8).
product(tech_tablet, tech_net, laptop, 1000, 2.5).
product(galaxy_tab_10, samsung, tablet, 510, 3.9).
product(ipad_air, apple, tablet, 749, 4.7).
product(ipad_mini, apple, tablet, 549, 4.1).
product(three_ft_hdmi_cable, sony, cable, 20, 4.0).
product(two_ft_hdmi_cable, sony, cable, 15, 3.9).
product(one_ft_hdmi_cable, sony, cable, 10, 3.5).

%%%%%  Atomic propositions regarding if a product is in stock
inStock(macbook_pro, eaton_centre_computer_shack, 25).
inStock(macbook_pro, square_one_computer_shack, 13).
inStock(macbook_air, dufferin_mall_computer_shack, 20).
inStock(macbook_air, square_one_computer_shack, 20).
inStock(microsoft_surface_go, dufferin_mall_computer_shack, 30).
inStock(microsoft_surface_go, centre_de_eaton_computer_shack, 35).
inStock(lenovo_thinkpad, dufferin_computer_shack, 15).
inStock(lenovo_thinkpad, centre_de_eaton_computer_shack, 15).
inStock(tech_tablet, square_one_computer_shack, 5).
inStock(galaxy_tab_10, square_one_computer_shack, 20).
inStock(galaxy_tab_10, eaton_centre_computer_shack, 18).
inStock(galaxy_tab_10, centre_de_eaton_computer_shack, 11).
inStock(ipad_air, eaton_centre_computer_shack, 1).
inStock(ipad_mini, square_one_computer_shack, 7).
inStock(three_ft_hdmi_cord, centre_de_eaton_computer_shack, 12).
inStock(two_ft_hdmi_cord, eaton_centre_computer_shack, 12).
inStock(two_ft_hdmi_cord, centre_de_eaton_computer_shack, 12).
inStock(one_ft_hdmi_cord, eaton_centre_computer_shack, 10).
inStock(one_ft_hdmi_cord, centre_de_eaton_computer_shack, 10).

%%%%% Atomic propositions for location of stores
location(eaton_centre_computer_shack, toronto).
location(dufferin_mall_computer_shack, toronto).
location(square_one_computer_shack, mississauga).
location(centre_de_eaton_computer_shack, montreal).

%%%%% Atomic propositions for shipping locations
canShip(macbook_pro, toronto).
canShip(macbook_pro, mississauga).
canShip(macbook_air, toronto).
canShip(macbook_air, mississauga).
canShip(microsoft_surface_go, toronto).
canShip(microsoft_surface_go, montreal).
canShip(lenovo_thinkpad, toronto).
canShip(lenovo_thinkpad, montreal).
canShip(galaxy_tab_10, toronto).
canShip(galaxy_tab_10, montreal).
canShip(ipad_air, toronto).
canShip(ipad_mini, toronto).
canShip(three_ft_hdmi_cord, montreal).
canShip(two_ft_hdmi_cord, toronto).
canShip(two_ft_hdmi_cord, montreal).
canShip(one_ft_hdmi_cord, toronto).
canShip(one_ft_hdmi_cord, montreal).

%%%%% LEXICON
article(a).
article(an).
article(any).
article(the).

% Product
proper_noun(X) :- product(X, Manufacturer, Type, Price, Rating).

% Manufacturer
proper_noun(X) :- product(ProductName, X, Type, Price, Rating).

% Product type
proper_noun(X) :- product(ProductName, Manufacturer, X, Price, Rating).

% Price
proper_noun(X) :- product(ProductName, Manufacturer, Type, X, Rating).

% Rating
proper_noun(X) :- product(ProductName, Manufacturer, Type, Price, X).

% location
proper_noun(X) :- location(X, _).
proper_noun(X) :- location(_, X).

% common nouns found in the database
common_noun(laptop, X) :- product(X, _, laptop, _, _).
common_noun(tablet, X) :- product(X, _, tablet, _, _).
common_noun(hdmi_cable, X) :- product(X, _, hdmi_cable, _, _).
common_noun(hdmi_cord, X) :- product(X, _, hdmi_cord, _, _).
common_noun(monitor, X) :- product(X, _, monitor, _, _).

common_noun(stock, X) :- inStock(_, _, X).
common_noun(rating, X) :- product(_, _, _, _, X).
common_noun(price, X) :- product(_, _, _, X, _).

% a store can be at a location or have a stock of a product
common_noun(store, X) :- location(X, _).
common_noun(store, X) :- inStock(_, X, _).

% a city can be shipped to or be the location of a store
common_noun(city, X) :- canShip(_, X).
common_noun(city, X) :- location(_, X).


% 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000


% store in city
preposition(in, X, Y) :- location(X, Y).
% product in city
preposition(in, X, Y) :- inStock(X, StoreName, _), location(StoreName, Y).
% product in store
preposition(in, X, Y) :- inStock(X, Y, _).

% count of product at store
preposition(at, X, Y) :- inStock(_, Y, X).
% product at store location
preposition(at, X, Y) :- inStock(X, Y, _).

% store with product X store Y product
preposition(with, X, Y) :- inStock(Y, X, _).

% product X can ship to city location Y
preposition(that_can_ship_to, X, Y) :- canShip(X, Y).
% product type X can ship to city location Y
preposition(that_can_ship_to, X, Y) :- product(ProductName, dell, X, _, _),  canShip(ProductName, Y).

% rating of
preposition(of, X, Y) :- product(Y, _, _, _, X).
% price of
preposition(of, X, Y) :- product(Y, _, _, X, _).
% stock of
preposition(of, X, Y) :- inStock(Y, _, X).

% 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

% adjectives of brands
adjective(dell, X) :- product(X, dell, _, _, _).
adjective(apple, X) :- product(X, apple, _, _, _).
adjective(rocketfish, X) :- product(X, rocketfish, _, _, _).
adjective(samsung, X) :- product(X, samsung, _, _, _).
adjective(sony, X) :- product(X, sony, _, _, _).
adjective(tech_net, X) :- product(X, tech_net, _, _, _).
adjective(microsoft, X) :- product(X, microsoft, _, _, _).
adjective(lenovo, X) :- product(X, lenovo, _, _, _).

adjective(highly_rated, X) :- product(X, _, _, _, Rating), Rating >= 4.0.
adjective(medium_rated, X) :- product(X, _, _, _, Rating), Rating >= 2.5, Rating < 4.0.
adjective(lowly_rated, X) :- product(X, _, _, _, Rating), Rating < 2.5.

% cheapest product of the same brand
adjective(cheapest, X) :- product(X, Manufacturer, Type, Price, _), not (product(ProductName, Manufacturer, Type, Price2, _), not ProductName = X, Price >= Price2).
% cheapest product of the same type
adjective(cheapest, X) :- product(X, Manufacturer, Type, Price, _), not (product(ProductName, Manufacturer2, Type, Price2, _), not ProductName = X, Price >= Price2).

adjective(expensive, X) :- product(ProductName, Manufacturer, Type, Price, _),  adjective(cheapest, ProductName), product(X, Manufacturer2, Type, Price2, _), Price2 >= 2 * Price.
