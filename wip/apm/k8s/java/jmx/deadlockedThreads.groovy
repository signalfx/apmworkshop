threadsMBean = util.queryJMX("java.lang:type=Threading").first()
server = threadsMBean.server()

deadlockedThreads = server.invoke(threadsMBean.name(), "findDeadlockedThreads", null, null)

runtimeMBean = util.queryJMX("java.lang:type=Runtime").first()

def dims = [vmname: runtimeMBean.VmName]

output.sendDatapoints([
        util.makeGauge(
                "jmx.threads.deadlocked.count",
                deadlockedThreads ? deadlockedThreads.length : 0.0,
                dims)
])
