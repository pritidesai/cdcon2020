open http://127.0.0.1:32426
open http://127.0.0.1:32428
open http://127.0.0.1:32424

kubectl get pr 02-build-test-deploy-in-cluster -o json | jq .status.skippedTasks

kubectl get pr 03-guarded-build-test-deploy -o json | jq .status.skippedTasks
