# oc rsh

azureuser@octest:~$ oc rsh -h
Open a remote shell session to a container

This command will attempt to start a shell session in a pod for the specified resource.
It works with pods, deployment configs, jobs, daemon sets, and replication controllers.
Any of the aforementioned resources (apart from pods) will be resolved to a ready pod.
It will default to the first container if none is specified, and will attempt to use
'/bin/sh' as the default shell. You may pass an optional command after the resource name,
which will be executed instead of a login shell. A TTY will be automatically allocated
if standard input is interactive - use -t and -T to override. A TERM variable is sent
to the environment where the shell (or command) will be executed. By default its value
is the same as the TERM variable from the local environment; if not set, 'xterm' is used.

Note, some containers may not include a shell - use 'oc exec' if you need to run commands
directly.

Usage:
  oc rsh [options] POD [COMMAND]

Examples:

  # Open a shell session on the first container in pod 'foo'
  oc rsh foo

  # Run the command 'cat /etc/resolv.conf' inside pod 'foo'
  oc rsh foo cat /etc/resolv.conf

  # See the configuration of your internal registry
  oc rsh dc/docker-registry cat config.yml

  # Open a shell session on the container named 'index' inside a pod of your job
  # oc rsh -c index job/sheduled

Options:
  -c, --container='': Container name; defaults to first container
  -T, --no-tty=false: Disable pseudo-terminal allocation
      --shell='/bin/sh': Path to the shell command
  -t, --tty=false: Force a pseudo-terminal to be allocated

Use "oc options" for a list of global command-line options (applies to all commands).
azureuser@octest:~$

# Firewall-Regeln

## Outgoing


 980 8443
1000 deny-all

azureuser@octest:~$ oc rsh mlbparks-mongodb-1-njzu7
sh-4.2$ exit
azureuser@octest:~$ oc exec -h
