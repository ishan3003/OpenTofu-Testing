# IDP-11664 mock responses

Mock bodies for the 21-workflow regression pack (SelectFieldFromApi / ValidateAndFetch / CustomField).
Served through backend-proxy endpoints named `idp11664-*`; see `proxy-endpoints.yaml`.
raw.githubusercontent.com is GET-only, so the test workflows use GET for every mocked call.
