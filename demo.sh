open http://127.0.0.1:32426

tkn pr list
tkn pr describe 02-build-test-deploy-in-cluster
kubectl get pr 02-build-test-deploy-in-cluster -o json | jq .status.skippedTasks
open http://127.0.0.1:32428

tkn pr list
tkn pr describe 03-guarded-build-test-deploy
kubectl get pr 03-guarded-build-test-deploy -o json | jq .status.skippedTasks

tkn pr list
tkn pr describe 04-build-test-deploy-cleanup
kubectl get pr 04-build-test-deploy-cleanup -o json | jq .status.skippedTasks

open http://127.0.0.1:32434
