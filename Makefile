test-pytest:
	vagrant ssh -c "docker pull quay.io/sighup/katalog:1.0.11_3" $(FURY_VM_ID)
	vagrant ssh -c "docker run -w /test_dir -v /workspace/sighup/fury-kubernetes-logging:/test_dir quay.io/sighup/katalog:1.0.11_3 sh -c \"pwd; ls ; flake8 --ignore=E501 katalog/tests/test.py; bash katalog/tests/pytest.sh; rm -rf .pytest_cache katalog/tests/__pycache__ ;\"" $(FURY_VM_ID)
test-apply:
	vagrant ssh -c "docker pull quay.io/sighup/kind:0.1.0_v1.12.0_1.0.11" $(FURY_VM_ID)
	vagrant ssh -c "docker run -ti -w /test_dir -v /workspace/sighup/fury-kubernetes-logging:/test_dir -v /workspace:/workspace -e LOCAL_DEV_ENV=true -e CLUSTER_HOST=localhost -e KUBECONFIG=/workspace/kubeconfig --network=host quay.io/sighup/kind:0.1.0_v1.12.0_1.0.11 \"bats -p katalog/tests/tests.bats\"" $(FURY_VM_ID)

test-pytest-docker:
	docker run -w /test_dir -v /home/phisco/workspace/sighup/fury-kubernetes-logging:/test_dir quay.io/sighup/katalog:1.0.11_3 sh -c "pwd; ls ; flake8 --ignore=E501 katalog/tests/test.py; bash katalog/tests/pytest.sh; rm -rf .pytest_cache katalog/tests/__pycache__ ;"
test: test-1 test-3
