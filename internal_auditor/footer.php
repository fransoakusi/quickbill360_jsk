<?php
/**
 * Shared Footer Template for Internal Auditor
 * File: internal_auditor/footer.php
 */

if (!defined('QUICKBILL_305')) {
    die('Direct access not permitted');
}
?>
        </div><!-- End Main Content -->
    </div><!-- End Container -->

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const isMobile = window.innerWidth <= 768;
            
            if (isMobile) {
                sidebar.classList.toggle('mobile-show');
            } else {
                sidebar.classList.toggle('hidden');
            }
        }

        // Close mobile sidebar when clicking outside
        document.addEventListener('click', function(e) {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.querySelector('.toggle-btn');
            
            if (window.innerWidth <= 768 && 
                sidebar.classList.contains('mobile-show') && 
                !sidebar.contains(e.target) && 
                !toggleBtn.contains(e.target)) {
                sidebar.classList.remove('mobile-show');
            }
        });
    </script>
</body>
</html>