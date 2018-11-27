update Farmers_Markets_Products set Delete_Flag = 1 where
--select * from Farmers_Markets_Products where 
							Credit= 'N'
						and WIC='N'
						and WICcash='N'
						and SFMNP='N'
						and SNAP='N'
						and Organic='-'
						and Bakedgoods=''
						and Cheese=''
						and Crafts=''
						and Flowers=''
						and Eggs=''
						and Seafood=''
						and Herbs=''
						and Vegetables=''
						and Honey=''
						and Jams=''
						and Maple=''
						and Meat=''
						and Nursery=''
						and Nuts=''
						and Plants=''
						and Poultry=''
						and Prepared=''
						and Soap=''
						and Trees=''
						and Wine=''
						and Coffee=''
						and Beans=''
						and Fruits=''
						and Grains=''
						and Juices=''
						and Mushrooms=''
						and PetFood=''
						and Tofu=''
						and WildHarvested=''
						
						
						
select Delete_Flag, count(1) 
	from Farmers_Markets_Products 
	group by Delete_Flag
select Delete_Flag, count(1) 
	from Farmers_Markets_Products 
	group by Delete_Flag
select * from Farmers_Markets_Products where Delete_Flag = 0


		