from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time
import math
browser = webdriver.Chrome()

try:
   browser.get("https://magento.softwaretestingboard.com/")
   link = browser.find_element(By.LINK_TEXT,'Create an Account')
   link.click()
   name = browser.find_element(By.NAME, 'firstname')
   name.send_keys('Peter')
   lastn = browser.find_element(By.ID, 'lastname')
   lastn.send_keys('Zhgunov')
   check = browser.find_element(By.CLASS_NAME, 'checkbox')
   check.click()
   email = browser.find_element(By.ID, 'email_address')
   email.send_keys('rtweertik@gmail.com')
   password = browser.find_element(By.ID, 'password')
   password.send_keys('8912Weyd18')
   confirm = browser.find_element(By.ID, 'password-confirmation')
   confirm.send_keys('8912Weyd18')
   button = browser.find_element(By.XPATH, '//*[@id="form-validate"]/div/div[1]/button/span')
   browser.execute_script("return arguments[0].scrollIntoView(true);", button)
   #browser.execute_script("window.scrollBy(0,50);")
   button.click()






   time.sleep(10)
finally:
  browser.quit()
