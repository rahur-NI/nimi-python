<%page args="f, config, method_template"/>\
<%
    '''Renders a GrpcStubInterpreter method for GetDeembeddingSparameters that returns a numpy array of complex numbers.'''
    import build.helper as helper
    full_func_name = f['interpreter_name'] + method_template['method_python_name_suffix']
    method_decl_params = helper.get_params_snippet(f, helper.ParameterUsageOptions.INTERPRETER_METHOD_DECLARATION)
    grpc_name = f.get('grpc_name', f['name'])
    grpc_request_args = helper.get_params_snippet(f, helper.ParameterUsageOptions.GRPC_REQUEST_PARAMETERS)
    included_in_proto = f.get('included_in_proto', True)
%>\

    def ${full_func_name}(${method_decl_params}):  # noqa: N802
% if included_in_proto:
        import numpy
        response = self._invoke(
            self._client.${grpc_name},
            grpc_types.${grpc_name}Request(${grpc_request_args}),
        )
        sparameters_array = numpy.array([c.real + 1j * c.imaginary for c in response.sparameters], dtype=numpy.complex128)
        return sparameters_array, response.number_of_sparameters, response.number_of_ports
% else:
        raise NotImplementedError('${full_func_name} is not supported over gRPC')
% endif