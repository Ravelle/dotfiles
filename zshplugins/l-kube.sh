    #source <(kubectl completion bash) # Enable auto completion

    alias fresh-pods='watch -n0.001 kubectl get pods'
    alias pods='k get pods'
    alias p='k get pods' 
    alias wp='while true; do clear; k get pods; sleep 5; done'
    alias k=kubectl
    alias n=namespace
    
    export KOPS_STATE_STORE=s3://lantum-kops
    export NAME=k.lantum.com
    
    export KUBE_EDITOR='vim'
    
    function forward {
     port=$2
     service=$(k get pods | grep $1 | head -1 | cut -d ' ' -f1)
     echo "Forwarding pod $service on port $port"
     kubectl port-forward "$service" $port
    }
    function delete {
     service=$(k get -n staging pods | grep $1 | head -1 | cut -d ' ' -f1)
    	echo "Deleting pod on staging $service"
    	kubectl delete pod "$service"
    }
    function logs {
    	service=$1
    	shift
    	kubectl logs --tail=100 -f "deployment/$service" $@
    }
    function kbash {
    	service=$(k get pods | grep $1 | grep Running | head -1 | cut -d ' ' -f1)
    	echo "Executing bash on $service"
    	shift
    	kubectl exec "$service" -it bash $@
    }
    
    function ksh {
    	service=$(k get pods | grep $1 | grep Running | head -1 | cut -d ' ' -f1)
    	echo "Executing bash on $service"
    	shift
    	kubectl exec "$service" -it sh $@
    }
    function describe {
    	service=$(k get pods | grep $1 | head -1 | cut -d ' ' -f1)
    	echo "Executing describe on $service"
    	k describe pod "$service"
    }
    function namespace {
    	echo "Setting namespace $1"
    	kubectl config set-context $(kubectl config current-context) --namespace=$1
    }


