from libveronica.Veronica import Veronica

vero = Veronica()
stoken = vero.login("cron","ToAruMajutsuNoIndex")
vero.rebuildFTSIndex()

print "Completado"