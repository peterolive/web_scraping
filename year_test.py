from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import csv
import re

# Windows users need to specify the path to chrome driver you just downloaded.
# You need to unzip the zipfile first and move the .exe file to any folder you want.
# driver = webdriver.Chrome(r'path\to\the\chromedriver.exe')
driver = webdriver.Chrome()
# Go to the page that we want to scrape
driver.get("https://www.kicksonfire.com/air-jordan-release-dates/")

csv_file = open('year.csv', 'w')
writer = csv.writer(csv_file)


# while True:
# 	try:
# 		time.sleep(3)
# 		wait_button = WebDriverWait(driver, 10)
# 		current_button = wait_button.until(EC.element_to_be_clickable((By.XPATH,
# 									'//button[@class="btn btn-default"]')))
# 		current_button.click()
# 	except Exception as e:
# 		break
time.sleep(5)
elements = driver.find_elements_by_xpath('//ul[@class = "sub-pages-continer"]//li/a')
links = []

for i in range(len(elements)):
	links.append(elements[i].get_attribute('href'))
	print(links[i])

for i in range(len(links[4: ])):
	time.sleep(5)
	print('navigating to: ' + links[i+4])
	driver.get(links[i+4])
	time.sleep(5)
	elements1 = driver.find_elements_by_xpath('//div[@class = "td-pb-padding-side td-page-content"]//li')
	link_dict = {}
	year = 2011 + i
	for i in range(len(elements1)):
		name = elements1[i].text
		print(name)
		year = year
		print(year)

		link_dict['name'] = name
		link_dict['year'] = year
		
		writer.writerow(link_dict.values())

	driver.back()


csv_file.close()
driver.close()
