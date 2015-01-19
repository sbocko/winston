package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class AnalysisController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Analysis.list(params), model:[analysisInstanceCount: Analysis.count()]
    }

    def show(Analysis analysisInstance) {
        respond analysisInstance
    }

    def create() {
        respond new Analysis(params)
    }

    @Transactional
    def save(Analysis analysisInstance) {
        if (analysisInstance == null) {
            notFound()
            return
        }

        if (analysisInstance.hasErrors()) {
            respond analysisInstance.errors, view:'create'
            return
        }

        analysisInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'analysis.label', default: 'Analysis'), analysisInstance.id])
                redirect analysisInstance
            }
            '*' { respond analysisInstance, [status: CREATED] }
        }
    }

    def edit(Analysis analysisInstance) {
        respond analysisInstance
    }

    @Transactional
    def update(Analysis analysisInstance) {
        if (analysisInstance == null) {
            notFound()
            return
        }

        if (analysisInstance.hasErrors()) {
            respond analysisInstance.errors, view:'edit'
            return
        }

        analysisInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Analysis.label', default: 'Analysis'), analysisInstance.id])
                redirect analysisInstance
            }
            '*'{ respond analysisInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Analysis analysisInstance) {

        if (analysisInstance == null) {
            notFound()
            return
        }

        analysisInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Analysis.label', default: 'Analysis'), analysisInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'analysis.label', default: 'Analysis'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
