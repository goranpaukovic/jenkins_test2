docker run -i \
           --user $(id -u):$(id -g) \
           -v $PWD/unit_tests:/workdir/unit_tests \
           -v $PWD/scripts_pipelines:/workdir/scripts_pipelines \
           --workdir=/workdir python:3.12.0a1-alpine3.16 \
           ./scripts_pipelines/execute_tests.sh