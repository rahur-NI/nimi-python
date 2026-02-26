<%page args="function, config, method_template, indent"/>\
<%
    import build.helper as helper
    sparameters_param = [p for p in function['parameters'] if p['python_name'] == 'sparameters'][0]
%>\
    .. py:method:: ${function['python_name']}()
${helper.get_documentation_for_node_rst(function, config, indent)}
        :rtype: numpy.array(dtype=numpy.complex128)
        :return:
${helper.get_documentation_for_node_rst(sparameters_param, config, indent + 8)}
