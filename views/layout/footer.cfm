        <cfoutput>
            <footer class="footer bg-dark mt-auto fixed-bottom pt-3">
                <div class="container-fluid">
                    <p class="text-white text-center">
                        &copy;&nbsp;Copyright&nbsp;#Year(Now())#&nbsp;#Config.Name#
                    </p>
                </div>
            </footer>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
            <script src="#Config.Assets#/js/site.js"></script>
            <cfloop array="#JavaScript#" index="Script">
                #Script#
            </cfloop>
        </cfoutput>
    </body>
</html>