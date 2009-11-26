require 'rubygems'
require 'mechanize'

def submit(username, password, to, body)
  agent = WWW::Mechanize.new
  p = agent.get("https://my.vodafone.nl/prive/my_vodafone/gratis_sms_versturen?errormessage=&errorcode=")
  f = p.form("login") || exit(2)
  f.username = username
  f.password = password
  sms_page = agent.submit(f)
  #sms_page.search("Wachtwoord vergeten?") do || echo '123'
  #exit(6) unless sms_page.links.text("Gratis SMS versturen")
  sms_form = sms_page.form("controle") || exit(4)
  sms_form.phoneNumber = to
  sms_form.body = body
  done_page = agent.submit(sms_form)
  #exit(5) unless done_page.links.text("Sluiten en terug naar My vodafone startpagina")
end

def die(x)
  puts x
  exit 8
end

die("Not enough parameters") if ARGV.size < 4
username = ARGV[0]
password = ARGV[1]
number = ARGV[2]
body = ARGV[3..-1].join(" ")

submit(username, password, number, body)